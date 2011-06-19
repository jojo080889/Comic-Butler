document.observe("dom:loaded", function() {
	
	// if links are clicked, mark as read
	var feeditemlinks = $$("#feeditems li a");
	for (var i = 0; i < feeditemlinks.length; i++) {
	    var f = feeditemlinks[i];
	    if (!f.parentNode.parentNode.hasClassName("read")) {
		f.observe('click', markAsRead);
	    }
	}

	// set up "Mark as Read" buttons
	var markAsReadButtons = $$(".markRead");
	for (var i = 0; i < markAsReadButtons.length; i++) {
	    var b = markAsReadButtons[i];
	    b.observe('click', markAsReadButton);
	}

	// set up "Mark as Unread" buttons
	var markAsUnreadButtons = $$(".markUnread");
	for (var i = 0; i < markAsUnreadButtons.length; i++) {
	    var b = markAsUnreadButtons[i];
	    b.observe('click', markAsUnreadButton);
	}
});

function markAsRead(event) {
    new Ajax.Request("/feeditems/" + this.parentNode.parentNode.readAttribute("id"),
        {
            method : "put",
	    parameters: {what: "markAsRead"},
            onSuccess : markAsReadSuccess,
            onFailure : ajaxFailure,
            onException : ajaxFailure
        }
    );
    var button = this.parentNode.parentNode.childNodes[1];
    button.innerHTML = "Mark as Unread";
    this.parentNode.parentNode.addClassName("read");
    button.addClassName("markUread");
    button.removeClassName("markRead");
    this.stopObserving('click', markAsRead);
    button.stopObserving('click', markAsReadButton);
    button.observe('click', markAsUnreadButton);
    reduceUnreadCount();
}

function markAsReadButton(event) {
    new Ajax.Request("/feeditems/" + this.parentNode.readAttribute("id"),
        {
            method : "put",
	    parameters: {what: "markAsRead"},
            onSuccess : markAsReadSuccess,
            onFailure : ajaxFailure,
            onException : ajaxFailure
        }
    );
    var link = this.parentNode.childNodes[3].childNodes[0];
    this.innerHTML = "Mark as Unread";
    this.parentNode.addClassName("read");
    this.addClassName("markUnread");
    this.removeClassName("markRead");
    this.stopObserving('click', markAsReadButton);
    link.stopObserving('click', markAsRead);
    this.observe('click', markAsUnreadButton);
    reduceUnreadCount();
}

function markAsUnreadButton(event) {
    new Ajax.Request("/feeditems/" + this.parentNode.readAttribute("id"),
        {
            method : "put",
	    parameters: {what: "markAsUnread"},
            onSuccess : markAsUnreadSuccess,
            onFailure : ajaxFailure,
            onException : ajaxFailure
        }
    );
    var link = this.parentNode.childNodes[3].childNodes[0];
    this.innerHTML = "Mark as Read";
    this.parentNode.removeClassName("read");
    this.addClassName("markRead");
    this.removeClassName("markUnread");
    this.stopObserving('click', markAsUnreadButton);
    this.observe('click', markAsRead);
    this.observe('click', markAsReadButton);
    increaseUnreadCount();
}

function markAsReadSuccess(ajax) {
    window.location.reload();
}

function markAsUnreadSuccess(ajax) {
    window.location.reload();
}

function reduceUnreadCount() {
    $("unreadCount").innerHTML = (parseInt($("unreadCount").innerHTML) - 1);
}

function increaseUnreadCount() {
    $("unreadCount").innerHTML = (parseInt($("unreadCount").innerHTML) + 1);
}

// called when Ajax has an error; displays an error message
function ajaxFailure(ajax, exception) {
    alert("Error making Ajax request:" + 
          "\n\nServer status:\n" + ajax.status + " " + ajax.statusText + 
          "\n\nServer response text:\n" + ajax.responseText);
    if (exception) {
        throw exception;
    }
}