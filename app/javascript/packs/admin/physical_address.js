const fosterSelector = $('#organization_foster_based');
const physicalAddressesSelector = $('#physical_addresses');

function togglePhysicalAddresses() {
  if(fosterSelector.is(':checked'))
    physicalAddressesSelector.show();
  else
    physicalAddressesSelector.hide();
}

export default class PhysicalAddress {
  new() {
    $(fosterSelector).on('change', togglePhysicalAddresses);
    togglePhysicalAddresses();
  }
}