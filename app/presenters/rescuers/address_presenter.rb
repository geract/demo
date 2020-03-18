module Rescuers
  class AddressPresenter
     def initialize(address)
       @address = address
     end

     def response
       {
         name: address.name,
         address: address.address,
         city: address.city,
         state: address.state,
         zip_code: address.zip_code,
         main_location: address.main_location
       }
     end

     private

     attr_reader :address
  end
end
