require 'spec_helper'

#please describe the transaction script class in the same way as below in order to
#maintain the form of the tests

describe TransactionScript do

#this refers to the transactionscript_spec_helper and needs to be used at the
#beginning of every transaction script.
  it_behaves_like('TransactionScripts')
end

