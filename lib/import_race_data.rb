require 'bundler/setup'
require 'nokogiri'
require 'open-uri'
require 'csv'

class ImportRaceData

  INDEX_YEAR = [2020, 2021] # データを取得したい年
  CSV_HEADER = ['日時', '競馬場', 'レース名', 'グレード', '距離', '種別', '着順', '枠', '馬番', '馬名', '性別', '騎手', '調教師']

  def setup_doc(url)
    doc = Nokogiri::HTML.parse(URI.open(url, "r:CP932").read)
    doc.search('br').each { |n| n.replace("\n") }
    doc
  end

  def scrape_data(data)
    horse_data = []
    # 着順
    horse_data << data.children[1].text
    # 枠
    horse_data << data.children[3].children[0].values.second[1]
    # 馬番
    horse_data << data.children[5].children.text
    # 馬名
    horse_data << data.children[7].text
    # 性別
    horse_data << data.children[9].text[0]
    # 騎手
    horse_data << data.children[13].text.gsub(" ", "")
    # 調教師
    horse_data << data.children[25].text.gsub(" ", "")

    horse_data.map(&:strip)
  end

  def race_info(doc)
    race_info = []
    date_text = doc.xpath("//div[@class='cell date']").text
    # 日時
    race_info << date_text.split('（').first.gsub(/年|月|日/, '年'=>'/', '月'=>'/', '日'=>'/')
    # 競馬場
    race_info << date_text.split('回').second[0,2]
    # レース名
    race_info << doc.xpath("//span[@class='race_name']").text
    # グレード
    race_info << doc.xpath("//span[@class='grade_icon lg']").first.children.attribute('alt').value

    course = doc.xpath("//div[@class='cell course']").text.delete('コース：メートル').split('（')
    # 距離
    race_info << course.first.delete(',')
    # 種別
    race_info << course.second.split('・').first

    race_info.map(&:strip)
  end

    # 結果ページURLの配列を生成
  def create_result_urls(doc)
    table_data = doc.xpath("id('contentsBody')/div[@class='scr-md']/table[@class='basic narrow-xy striped mt20']/tbody[@class='td_left']/tr")
    urls = table_data.map do |data|
      result_path = data&.children[15]&.children[0]&.values&.first
      "https://www.jra.go.jp/#{result_path}" if result_path.present?
    end

    urls.compact
  end

  # 年から重賞ページの配列を生成
  def index_urls(years = [])
    urls = years&.map do |year|
      "https://www.jra.go.jp/datafile/seiseki/replay/#{year}/jyusyo.html"
    end

    urls
  end

  def exec
    index_url_list = index_urls(INDEX_YEAR)
    urls = index_url_list.map do |index_url|
      index_doc = setup_doc(index_url)
      create_result_urls(index_doc)
    end.flatten

    CSV.open('./lib/result.csv', 'w') do |csv|
      csv << CSV_HEADER
      urls.each do |url|
        begin
          doc = setup_doc(url)
          race_info_columns = race_info(doc)
          table_data = doc.xpath("id('race_result')/div[@class='race_result_unit']/table[@class='basic narrow-xy striped']/tbody[1]/tr")
          table_data.each do |data|
            csv << race_info_columns + scrape_data(data)
          end
        rescue => e
          p e
        end
      end
    end
  end
end