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
     file = "db/csv/customers.csv"
      CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
        customer_hash = row.to_hash
        customer = Customer.where(id: customer_hash[:id].to_i)
        if customer.count == 1
          customer.first.update_attributes(customer_hash)
        else
          Customer.create!(customer_hash)
        end
      end
    end


    desc "Import merchants from csv file"
      task :import_merchants => [:environment] do
       file = "db/csv/merchants.csv"
        CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
          merchant_hash = row.to_hash
          merchant = Merchant.where(id: merchant_hash[:id].to_i)
          if merchant.count == 1
            merchant.first.update_attributes(merchant_hash)
          else
            Merchant.create!(merchant_hash)
          end
        end
      end

    desc "Import invoices from csv file"
      task :import_invoices => [:environment] do
       file = "db/csv/invoices.csv"
        CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
          invoice_hash = row.to_hash
          invoice = Invoice.where(id: invoice_hash[:id].to_i)
          if invoice.count == 1
            invoice.first.update_attributes(invoice_hash)
          else
            Invoice.create!(invoice_hash)
          end
        end
      end

      desc "Import items from csv file"
        task :import_items => [:environment] do
         file = "db/csv/items.csv"
          CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
            item_hash = row.to_hash
            item = Item.where(id: item_hash[:id].to_i)
            if item.count == 1
              item.first.update_attributes(item_hash)
            else
              Item.create!(item_hash)
            end
          end
        end

    desc "Import invoice_items from csv file"
      task :import_invoice_items => [:environment] do
       file = "db/csv/invoice_items.csv"
        CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
          invoice_item_hash = row.to_hash
          invoice_item = InvoiceItem.where(id: invoice_item_hash[:id].to_i)
          if invoice_item.count == 1
            invoice_item.first.update_attributes(invoice_item_hash)
          else
            InvoiceItem.create!(invoice_item_hash)
          end
        end
      end

      desc "Import transactions from csv file"
        task :import_transactions => [:environment] do
         file = "db/csv/transactions.csv"
          CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
            transaction_hash = row.to_hash.except(:credit_card_expiration_date)
            transaction = Transaction.where(id: transaction_hash[:id].to_i)
            if transaction.count == 1
            else
              Transaction.create!(transaction_hash)
            end
          end
        end
