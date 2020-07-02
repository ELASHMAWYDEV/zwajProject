console.log("connected to main js file");



/*-----------Required Functions BEGIN-----------*/

function show(e) {
    if(e !== null)
        e.style.display = 'block';
}
function hide(e) {
    if(e !== null)
        e.style.display = 'none';
}


/*-----------Required Functions END------------*/
/***********************************************/


/*---------------MAIN FUNCTIONS---------------*/





//burger menu
function burgerMenu(el) {
    // el.style.marginRight = ;
    document.querySelector('.sidebar').classList.toggle('sidebar-active');
}

/*---------closing----------------*/
function closeBox(el) {
    hide(el.parentNode);
    hide(document.querySelector('.box-container'));
}
/**********************************/

/*------select tag apperance------*/
function rotateSelect(select) {
    var span = select.nextElementSibling;
    span.classList.toggle('rotate');
    select.addEventListener('mouseleave', handler)
    function handler(e) {
        e.target.blur();
        span.classList.toggle('rotate');
        this.removeEventListener('mouseleave', handler);
    }
    
}
/**********************************/



/*---------Delete user Abort--------*/
function abort(el) {
    event.preventDefault();
    var delete_user_box = el.closest('.delete-user-box');
    hide(delete_user_box);
    hide(document.querySelector('.box-container'));
}
/************************************/


function popupBox(el, container = true) {

    el = document.querySelector(el);

    show(el);
    if(container) {
        //FLOATING BOX POSTION FIX
        el.style.top = Math.ceil(window.scrollY) + 'px';
        el.parentNode.style.display = 'flex';

        show(document.querySelector('.box-container'));
    }
    window.addEventListener('mouseup', handler);
    function handler(e) {
        e.preventDefault();
        if(!el.contains(e.target)) {
            if(container) {
                
                hide(document.querySelector('.box-container'));
            }
            hide(el);
            this.removeEventListener('mouseup', handler);
        }

        
    }  
}
///////////////////////////////////////////


/*------------Pagination BEGIN-----------*/

function DisplayTable (table_items, table_body, rows_per_page, page) {
    table_body.innerHTML = "";
    page--;

    let start = rows_per_page * page;
    let end = start + rows_per_page;
    let pagintedItems = Array.from(table_items).slice(start, end);
    for (let i = 0; i < pagintedItems.length; i++) {
        let item = pagintedItems[i];
        table_body.append(item);
    }

}

function SetupPagination (table_items, table_body, rows_per_page, pagination_container) {
    table_body.innerHTML = "";

    let page_count = Math.ceil(table_items.length  / rows_per_page);

    for (let i = 1; i < page_count + 1; i++) {
        let button = PaginationBtn(i, table_items);
        pagination_container.appendChild(button);
    }
}


function PaginationBtn(page, table_items) {
    let button = document.createElement('button');
    button.innerText = page;
    if(current_page == page) button.classList.add('active-page');
    button.addEventListener('click', function(e){
        
        current_page = page;
        DisplayTable(table_items, table_body, rows_per_page, current_page);

        let current_btn = document.querySelector('.pagination button.active-page');
        current_btn.classList.remove('active-page');
        this.classList.add('active-page');
    });
    return button;
}

//THIS WHOLE SECTION IS PUT IN THE END OF ANY PAGE THAT HAS A TABLE
            //==>START<==//
// var table_items = document.querySelectorAll('table tbody tr');
// var table_body = document.querySelector('table tbody');
// var pagintation_container = document.querySelector('.pagination');
// var current_page = 1;
// var rows_per_page = 10; ///number of rows shown on all tables
// SetupPagination(table_items, table_body, rows_per_page, pagintation_container);
// DisplayTable(table_items, table_body, rows_per_page, current_page); 
            //==>END<==//

/*------------Pagination END-----------*/
/////////////////////////////////////////


