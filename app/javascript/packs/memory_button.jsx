import React from 'react'
import ReactDOM from 'react-dom'
import '../memory_button/styles'

class MemoryButton extends React.Component {

  state = {
    id: this.props.id,
    buttonName: 'Memorize',
    memorized: this.props.memorized,
    buttonClass: this.props.memorized ? "memory-button button-memorized" : 'memory-button'
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
            buttonClass: 'memory-button'
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
          buttonClass: buttonClass + ' button-memorized'
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

let htmlCollection = document.getElementsByClassName('memory');
let elements = Array.from(htmlCollection);

elements.forEach(function(e){
  ReactDOM.render(<MemoryButton id={e.dataset.id} ayahId={e.dataset.ayah} memorized={e.dataset.memorized === 'true'}/>,  e);
});