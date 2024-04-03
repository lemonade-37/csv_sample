class StaticPagesController < ApplicationController
  require 'csv'

  def index
    @users = User.all
    @sales = Sale.all
    @account_informations = AccountInformation.all
  end

  def export
    @account_informations = AccountInformation.all

    respond_to do |format|
      format.csv { send_data generate_csv(@account_informations), filename: "CSVサンプル.csv" }
    end
  end

  private

  # GMOあおぞらネット銀行指定形式
  def generate_csv(account_informations)
    csv_data = CSV.generate(encoding: 'Shift_JIS') do |csv| # 文字コードをShift_JISに指定する必要があります。
      account_informations.each do |account_information|
        sale = Sale.find_by(user_id: account_information.user.id) # 振込金額を先に検索しておきます
        # この時の値の呼び出し方等はアプリに応じて調整してください。

        # GMOあおぞらネット銀行指定形式では、下記項目がこの順番で並んでいる必要があります。
        # 他細かいデータ形式は公式のPDF参照。
        csv << [
          account_information.bank_code,      # 銀行コード　：先頭の0は省略せず4桁で表記
          account_information.branch_code,    # 支店コード　：先頭の0は省略せず3桁で表記
          account_information.deposit_type,   # 預金種目　　：1(普通),2(当座),4(貯蓄)の数値で表記
          account_information.account_number, # 口座番号　　：先頭の0は省略せず7桁で表記
          account_information.bank_account,   # 受取口座名義：半角ｶﾀｶﾅで表記
          sale&.price,                        # 振込金額
          nil,                                # 手数料負担区分（空欄）
          nil,                                # 振り込み依頼人（空欄）
          nil                                 # EDI情報（空欄）
        ]
      end
    end
  end

end
