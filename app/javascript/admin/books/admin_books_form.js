document.addEventListener('DOMContentLoaded', function(){
    let button = document.getElementById("book_submit");
    validatePrice()
    button.addEventListener('click', function(event){
        if(!(validateBook() &&
        validatePrice() &&
        validateAvailableQuantity() &&
        validateTotalQuantity())){
            event.preventDefault();
            alert("Check your inouts properly!");
            return;
        }
        if( getTotalQuantity()< getAvailableQuantity()){
            event.preventDefault();
            alert("Total quantity should be more than available quantity");
            return;
        }
    })
});

function getAvailableQuantity() {
    let book_available_quantity = parseInt(document.getElementById("book_available_quantity")?.value);
    if(book_available_quantity < 0 || isNaN(book_available_quantity)){
        return 0;
    }
    else{
        return book_available_quantity;
    }
}

function getTotalQuantity() {
    let book_total_quantity = parseInt(document.getElementById("book_total_quantity")?.value);
    if(book_total_quantity < 0 || isNaN(book_total_quantity)){
        return 0;
    }
    else{
        return book_total_quantity;
    }
}

function validateBook(){
    let book_name = document.getElementById("book_name")?.value;
    if(book_name.trim().length <=1){
        return false;
    }
    return true;
}

function validatePrice(){
    let book_price = parseInt(document.getElementById("book_price")?.value);
    if(book_price <= 0 || isNaN(book_price)){
        return false;
    }
    return true;
}

function validateAvailableQuantity(){
    let book_available_quantity = parseInt(document.getElementById("book_available_quantity")?.value);
    if(book_available_quantity < 0 || isNaN(book_available_quantity)){
        return false;
    }
    return true;

}

function validateTotalQuantity(){
    let book_total_quantity = parseInt(document.getElementById("book_total_quantity")?.value);
    if(book_total_quantity < 0 || isNaN(book_total_quantity)){
        return false;
    }
    return true;

}