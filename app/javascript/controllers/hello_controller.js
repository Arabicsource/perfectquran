import { Controller } from "stimulus"

export default class extends Controller {
  greet() {
    const element = this.targets.find("name")
    const name = element.value
    console.log(`Hello, ${name}!`)
  }
}