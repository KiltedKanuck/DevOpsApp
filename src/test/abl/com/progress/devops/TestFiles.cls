 
 /*------------------------------------------------------------------------
    File        : TestFiles
    Author(s)   : Cameron David Wright - cwright@progress.com
    Created     : Thu May 20 09:03:51 EDT 2020
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
using OpenEdge.Core.Assert.

block-level on error undo, throw.

class com.progress.devops.TestFiles:
      
    @Test.
    method public void TestHelloExists(  ):  
        // make sure the code exists
        Assert:NotNull(search("com\progress\devops\hello.r")).
        return.
 
    end method.

    @Test.
    method public void TestCustomerExists(  ):  
        // make sure this exisits
        Assert:NotNull(search("com\progress\devops\customer.r")).
        return.
 
    end method.

end class.