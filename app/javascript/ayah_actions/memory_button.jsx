import React from 'react'
import ReactDOM from 'react-dom'

export default class MemoryButton extends React.Component {

  state = {
    id: this.props.id,
    memorized: this.props.memorized,
    buttonClass: this.props.memorized ? 'memorized' : '',
    icon: this.props.memorized ? 'fa fa-heart' : 'fa fa-heart-o',
    count: this.props.count
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
            buttonClass: '',
            icon: 'fa fa-heart-o',
            count: (Number.parseInt(that.state.count) - 1).toString()
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
          buttonClass: 'memorized',
          icon: 'fa fa-heart',
          count: (Number.parseInt(that.state.count) + 1).toString()
        })
      });
    }
  }

  render() {
    const { buttonClass, icon, count } = this.state

    return (
      <div>
        <a className={buttonClass} onClick={() => this.toggleMemory()}>
          <i className={icon}></i>
        </a>
        <div><span className="d-none d-lg-inline">Memories</span> {count}</div>
      </div>
    )
  }
}