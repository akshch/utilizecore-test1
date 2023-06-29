namespace :reports do
  desc "Daily Reports of Courier with Sender and Receiver details"
  task :daily_reports => :environment do
    report = Report.create
    informations = {}
    informations["header"] = ["Courier Id", "weight", "status", "Service Type", "payment_mode", "sender_id", "receiver_id", "cost", "Courier Created At", "Sender Name", "Sender Email", "Sender Address 1", "Sender Address 2", "Sender City", "Sender State", "Sender Country", "Sender Pincode", "Sender Mobile Number", "Recevier Name", "Recevier Email", "Recevier Address 1", "Recevier Address 2", "Recevier City", "Recevier State", "Recevier Country", "Recevier Pincode", "Recevier Mobile Number"]
    filename = "courier_reports_#{Time.now.strftime("%d-%m-%-Y-%H:%M")}"
    informations["title"] = "daily_courier_reports_for_#{Time.now.strftime("%d-%m-%-Y-%H:%M")}"
    informations['file']="#{Rails.root}/public/#{filename}.xlsx"
    book, sheet = create_spreadsheet(informations)
    counter = 0
    Parcel.includes(:service_type, sender: :address, receiver: :address).where("created_at::date =?", Date.yesterday).find_each do |parcel|
      sheet.row(counter=counter + 1).replace [parcel.id, parcel.weight, parcel.status, parcel.service_type.name, parcel.payment_mode, parcel.sender_id, parcel.receiver_id, parcel.cost, parcel.created_at.strftime("%d-%m-%-Y-%H:%M"), parcel.sender.name, parcel.sender.email, parcel.sender.address.address_line_one, parcel.sender.address.address_line_two, parcel.sender.address.city, parcel.sender.address.city, parcel.sender.address.state, parcel.sender.address.pincode, parcel.sender.address.mobile_number, parcel.receiver.name, parcel.receiver.email, parcel.receiver.address. address_line_one, parcel.receiver.address. address_line_two, parcel.receiver.address. city, parcel.receiver.address. city, parcel.receiver.address. state, parcel.receiver.address.  pincode, parcel.receiver.address. mobile_number]
      sheet.row(counter += 1).replace ["Parcels not found"] if counter == 0
      book.write informations["file"]
    end
    report.document.attach(io: File.open(informations["file"]), filename: "#{informations["title"]}.xlsx", content_type: 'xlsx')
    File::delete(informations["file"])
  end

  def create_spreadsheet(informations)
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => informations["title"].to_s
    format = Spreadsheet::Format.new :weight => :bold
    sheet.row(0).replace informations["header"]
    sheet.row(0).default_format = format
    return book, sheet
  end
end
