import React from 'react'
import ReactDOM from 'react-dom'

export default class MemoryButton extends React.Component {
  
  state = {
    id: this.props.id,
    buttonName: 'Memorize',
    memorized: this.props.memorized,
    buttonClass: this.props.memorized ? "ayah-action-button memorized" : 'ayah-action-button'
  }

  toggleMemory() {
    const that = this
    const { id, memorized, buttonClass } = this.state
    
    if(memorized) {
      $.ajax({
        type: 'DELETE',
        url: '/api/v1/ayahs/' + this.props.ayahId + '/memories/' + id,
      })
        .done(function(){
          that.setState({
            id: 0,
            buttonName: 'Memorize',
            memorized: false,
            buttonClass: 'ayah-action-button'
          })
        });
    } else {
      $.ajax({
        type: 'POST',
        url: '/api/v1/ayahs/' + this.props.ayahId + '/memories',
      })
      .done(function(data){
        that.setState({
          id: data.id,
          buttonName: 'Memorized',
          memorized: true,
          buttonClass: buttonClass + ' memorized'
        })
      });
    }
  }

  render() {
    const { buttonName, buttonClass } = this.state  

    return (
      <a className={buttonClass} onClick={() => this.toggleMemory()}>
        <i className="fa fa-heart"></i> {buttonName}
      </a>
    )
  }
}