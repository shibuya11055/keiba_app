class UploadRaceData
  require 'csv'

  def exec
    CSV.foreach('/Users/shibuya.kyohei/work/test_app/keiba_app/lib/result_1.csv', headers: true) do |row|
      p 'test'
    end
  end
end
