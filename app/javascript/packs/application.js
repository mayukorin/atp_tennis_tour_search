// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

//= require jquery-ui/widgets/autocomplete
// import "jquery"
// import "jquery-mapael"
// import 'bootstrap';
// import '../stylesheets/application';

Rails.start()
Turbolinks.start()
ActiveStorage.start()
require("jquery")
import "bootstrap"
/*
import "raphael"
import "jquery-mousewheel";
import "jquery-mapael/js/jquery.mapael.min.js";
import "jquery-mapael/js/maps/world_countries.js";
*/
import '../stylesheets/application'


