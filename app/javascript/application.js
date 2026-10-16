import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import $ from "jquery"
import toastr from "toastr"
import "bootstrap"

window.$ = window.jQuery = $
window.toastr = toastr
Rails.start()
Turbolinks.start()
ActiveStorage.start()
