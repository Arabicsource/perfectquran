import React from 'react'
import ReactDOM from 'react-dom'
import MemoryButton from '../ayah_actions/memory_button'
import '../ayah_actions/styles'

class AyahActions extends React.Component {

  render() {
    return (
      <div>
        <MemoryButton id={this.props.memoryId} ayahId={this.props.ayahId} memorized={this.props.memorized}/>
      </div>
    )
  }
}

let htmlCollection = document.getElementsByClassName('ayah-actions');
let elements = Array.from(htmlCollection);

elements.forEach(function(e){
  ReactDOM.render(
    <AyahActions 
      ayahId={e.dataset.ayahId} 
      memoryId={e.dataset.memoryId}
      memorized={e.dataset.memorized === 'true'}
    />,  
  e);
});