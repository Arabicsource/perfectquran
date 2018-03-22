import { Application } from "stimulus"
import { autoload } from "stimulus/webpack-helpers"
import axios from 'axios'

const application = Application.start()
const controllers = require.context("../controllers", true, /\.js$/)
autoload(controllers, application)

axios.defaults.headers.common['X-CSRF-Token'] = Rails.csrfToken()
axios.defaults.headers.common['Accept'] = 'application/json'

Turbolinks.start();