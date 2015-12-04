function myFunction() {
    alert("I am an alert box!");
}

var viewModel = function(){
    var self = this;

    self.clickTest = function(){
        alert("I've been clicked!");
    }  
};