console.log("connected to ajax file");


/*-----------Required Functions BEGIN-----------*/
function ajax(type, url, data, success)
{
    type = type.toUpperCase(); //transform type to uppercase to avoid errors

    //string the submitted data
    params = '?';
    for(var i in data) {
        params += i + '=' + data[i] + '&';
    }
    params = params.slice(0, -1);


    var xhr = new XMLHttpRequest();

    //get request
    if(type == 'GET')
    {
        url += params; //append data to url
        xhr.open(type, url, true);
        xhr.onloadend = function()
        {
            if(this.status == 200)
            {
                success(this.responseText);

            }
        }
        xhr.send();

    }
    else if(type == 'POST')
    {
        // remove the ? from @params
        params = params.slice(1);
        xhr.open(type, url, true);
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        xhr.onloadend = function()
        {
            if(this.status == 200)
            {
                success(this.responseText);

            }
        }
        xhr.send(params);
    }
    else
    {
        console.log("Developer Error => the request type: "+type+" is invalid");
    }
}



//convert all inputs to a json object
function inputToJson(parent,inputs)
{
    data = {
        success : [],
        errors : [],
        output : []
    };
    let i = 0;
    for(let input in inputs) {
        let name = input;
        let type = inputs[input];
        let value = parent.querySelector(type + '[name="'+ name +'"]').value;
        data.output[i] = {
            [name]: value,
            type: type
        };

        i++;
    }
    console.log(data);
    return data;
}



//put the returned values to the input fields
function outputToInput(parent,outputs)
{
    for(var output in outputs) {
        parent.querySelector('input[name="'+ output +'"]').setAttribute('value', outputs[output]);

    }
}


//display messages function => on ajax success => messages(ouput.errors, output.success);
function messages(errors = [], success = [])
{
    alarms = document.getElementById('alarms');
    if(errors.length > 0 || success.length > 0)
    {   
        show(alarms);

        //POSITION FIX
        alarms.style.top = window.pageYOffset + 20 + 'px';
        window.addEventListener('scroll', (e) => {
            alarms.style.top = window.pageYOffset + 20 + 'px';
        });

        var alarm = '';
        errors.forEach(err => {
            alarm += '<div class="alarm alarm-errors">' + err + '</div>';
        });

        success.forEach(succ => {
            alarm += '<div class="alarm alarm-success">' + succ + '</div>';
        })
        alarm += '</div>';
        alarms.innerHTML += alarm;
        setTimeout(function(){
            [].forEach.call(document.querySelectorAll('.alarm'), function(el) {
                el.remove();
            });
            hide(alarms);
        }, 3000);

    }
    else
    {
        return false;
    }
    
}

/*-----------Required Functions END------------*/
/***********************************************/
//save personal account settings

function update_account_settings(form){
    event.preventDefault();
    var update_account_settings = 'update_account_settings';
    data = inputToJson(form, {
        username:'input',
        email:'input',
        name:'input',
        phone:'input',
    });

    data = JSON.stringify(data);
    data = {update_account_settings:update_account_settings, data:data};
    ajax('post', ajaxUrl + 'common', data, function(output){
        output = JSON.parse(output);
        messages(output.errors, output.success);
        if(output.reload == 'true')
        {
            setTimeout(function(){
                window.location.reload();
            },2000);
        }
        else
        {
            outputToInput(form ,output.output);
        }            
    });
}
    


// //change personal account passwrod

function change_account_password(form){
    event.preventDefault();
    var change_account_password = 'change_account_password';
    data = inputToJson(form, {
        pass1:'input',
        pass2:'input'
    });

    data = JSON.stringify(data);
    data = {change_account_password:change_account_password, data:data};
    ajax('post', ajaxUrl + 'common', data, function(output){
        output = JSON.parse(output);
        messages(output.errors, output.success);
    });
}
    



// //add new admin
function add_new_admin(form) {
    event.preventDefault();
    var add_new_admin = 'add_new_admin';
    data = inputToJson(form, {
        username:'input',
        email:'input',
        name:'input',
        phone:'input',
        pass1:'input',
        pass2:'input',
    });

    data = JSON.stringify(data);
    data = {add_new_admin:add_new_admin, data:data};
    ajax('post', ajaxUrl + 'admins', data, function(output){
        output = JSON.parse(output);
        messages(output.errors, output.success);
        if(output.reload == 'true')
        {
            setTimeout(function(){
                window.location.reload();
            },2000);
        }
        else
        {
            outputToInput(form ,output.output);
        }            
    });
}

// /*----------Edit admin---------*/
function get_admin_edit(el) {
    event.preventDefault();
    id = el.getAttribute('data-admin-id');
    var edit_admin_box = document.querySelector('.edit-admin-box');
    edit_admin_box.querySelector('span.admin_id').textContent = id;
    edit_admin_box.querySelector('input[name="id"]').setAttribute('value', id);
    //get data
    var get_admin_by_id = 'get_admin_by_id';
    data = {get_admin_by_id:get_admin_by_id, id:id};
    ajax('post', ajaxUrl + 'admins', data, function(output){
        output = JSON.parse(output);
        messages(output.errors, output.success);
        if(output.reload == 'true')
        {
            setTimeout(function(){
                window.location.reload();
            },1000);
        }
        else
        {
            outputToInput(edit_admin_box, output.output); 
            popupBox('.edit-admin-box');  
        }
        
          
    });

}
    

function edit_admin(form) {
    event.preventDefault();
    var edit_admin = 'edit_admin';
    data = inputToJson(form, {
        username:'input',
        email:'input',
        name:'input',
        phone:'input',
    });

    data['id'] = id;
    data = JSON.stringify(data);
    data = {edit_admin:edit_admin, data:data};
    ajax('post', ajaxUrl + 'admins', data, function(output){
        output = JSON.parse(output);
        messages(output.errors, output.success);
        if(output.reload == 'true')
        {
            setTimeout(function(){
                window.location.reload();
            },2000);
        }
        else
        {
            outputToInput(form, output.output); 
        }
           
    });   
}

// /************************************/
// /*----------Delete admin---------*/
function get_admin_delete(el){
    id = el.getAttribute('data-admin-id');
    var delete_admin_box = document.querySelector('.delete-admin-box');
    delete_admin_box.querySelector('span.admin_id').innerHTML = id;
}
function delete_admin(form) {
    event.preventDefault();
    //get data
    var delete_admin_by_id = 'get_admin_by_id';
    data = {delete_admin_by_id:delete_admin_by_id, id:id}
    ajax('post', ajaxUrl + 'admins', data, function(output){
        output = JSON.parse(output);
        messages(output.errors, output.success);
        if(output.reload == 'true')
        {
            setTimeout(function(){
                window.location.reload();
            },2000);
        }
           
    });   
}
    


//SHOW USER INFO
function get_user_info (el) {
    event.preventDefault();
    const id = el.getAttribute('data-user-id');
    const show_user_box = document.querySelector('.show-user-box');
    show_user_box.querySelector('span.user_id').textContent = id;
    const table = document.querySelector('.show-user-table');
    // show_user_box.querySelectorAll('input[name="id"]').forEach(e => {e.setAttribute('value', id)});
    //get data
    const get_user_by_id = 'get_user_by_id';
    data = {get_user_by_id:get_user_by_id, id:id};
    ajax('post', ajaxUrl + 'users', data, function(output){
        console.log(output);
        output = JSON.parse(output);
        messages(output.errors, output.success);
        if(output.reload == 'true')
        {
            setTimeout(function(){
                window.location.reload();
            },1000);
        }
        else
        {
            table.innerHTML = output.output;
            popupBox('.show-user-box');  
        }
        
          
    });
    
}

function get_message(el){
    let id = el.getAttribute('data-id');
    let email = el.getAttribute('data-email');
    let sender = el.getAttribute('data-sender');
    let reason = el.getAttribute('data-reason');
    let msg = el.getAttribute('data-msg');


    var show_message_box = document.querySelector('.show-message-box');
    show_message_box.querySelector('span.message_id').innerHTML = id;
    show_message_box.querySelector('#msg').innerText = msg;
    show_message_box.querySelector('#sender').setAttribute('value', sender);
    show_message_box.querySelector('#email').setAttribute('value', email);
    show_message_box.querySelector('#reason').setAttribute('value', reason);


    popupBox('.show-message-box');
}