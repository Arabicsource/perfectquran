import React from 'react'
import ReactDOM from 'react-dom'

export default class MemoryButton extends React.Component {
  
  state = {
    id: this.props.id,
    memorized: this.props.memorized,
    buttonClass: this.props.memorized ? 'btn-ayah-action-memorized' : 'btn-ayah-action' 
  }

  toggleMemory() {
    const that = this
    const { id, memorized } = this.state
    
    if(memorized) {
      $.ajax({
        type: 'DELETE',
        url: '/api/v1/ayahs/' + this.props.ayahId + '/memories/' + id,
      })
        .done(function(){
          that.setState({
            id: 0,
            memorized: false,
            buttonClass: 'btn-ayah-action'
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
          memorized: true,
          buttonClass: 'btn-ayah-action-memorized'
        })
      });
    }
  }

  render() {
    const { buttonClass } = this.state

    return (
      <a className={buttonClass} onClick={() => this.toggleMemory()}>
        <i className="fa fa-heart"></i>
      </a>
    )
  }
}