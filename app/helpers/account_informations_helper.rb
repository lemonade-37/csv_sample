module AccountInformationsHelper
  def translate_deposit_type(deposit_type)
    case deposit_type
    when 1
      '普通'
    when 2
      '当座'
    when 4
      '貯蓄'
    end
  end
end
