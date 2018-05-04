require 'csv'
desc "Import all files at once"
  task :import_all => [:import_customers,
                       :import_merchants,
                       :import_invoices,
                       :import_items,
                       :import_invoice_items,
                       :import_transactions
                      ]

  desc "Import customers from csv file"
    task :import_customers => [:environment] do
      Transaction.destroy_all
      InvoiceItem.destroy_all
      Item.destroy_all
      Invoice.destroy_all
      Merchant.destroy_all
      Customer.destroy_all

     file = "db/csv/customers.csv"
      CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
        customer = Customer.create(row.to_hash)
      end
      puts "Created #{Customer.count} customers."
    end


    desc "Import merchants from csv file"
      task :import_merchants => [:environment] do
       file = "db/csv/merchants.csv"
        CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
          merchant = Merchant.create!(row.to_hash)
        end
        puts "Created #{Merchant.count} merchants."
      end

    desc "Import invoices from csv file"
      task :import_invoices => [:environment] do
       file = "db/csv/invoices.csv"
        CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
          invoice_hash = row.to_hash
          invoice = Invoice.create!(invoice_hash)
        end
        puts "Created #{Invoice.count} invoices."
      end

      desc "Import items from csv file"
        task :import_items => [:environment] do
         file = "db/csv/items.csv"
          CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
            item = Item.create!(row.to_hash)
          end
          puts "Created #{Item.count} items."
        end

    desc "Import invoice_items from csv file"
      task :import_invoice_items => [:environment] do
       file = "db/csv/invoice_items.csv"
        CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
          invoice_item = InvoiceItem.create!(row.to_hash)
        end
        puts "Created #{InvoiceItem.count} invoice-items. Almost done!"
      end

      desc "Import transactions from csv file"
        task :import_transactions => [:environment] do
         file = "db/csv/transactions.csv"
          CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
            transaction_hash = row.to_hash.except(:credit_card_expiration_date)
            transaction = Transaction.create!(transaction_hash)
          end
          puts "Created #{Transaction.count} transactions. Huzzah!"
        end
