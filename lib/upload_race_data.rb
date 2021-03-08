class UploadRaceData
  require 'csv'

  def exec
    CSV.foreach('/Users/shibuya.kyohei/work/test_app/keiba_app/lib/result_1.csv', headers: true) do |row|
      p 'test'
    end
  end
end

# 日時,レース名,グレード,距離,種別,着順,馬名,性別,騎手,調教師
