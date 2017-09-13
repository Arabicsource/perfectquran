import React from 'react'
import ReactDOM from 'react-dom'
import MemoryButton from '../ayah_actions/memory_button'
import FavoriteButton from '../ayah_actions/favorite_button'

class AyahActions extends React.Component {

  render() {
    return (
      <div>
        <MemoryButton id={this.props.memoryId} ayahId={this.props.ayahId} memorized={this.props.memorized} count={this.props.memoryCount}/>
        <FavoriteButton id={this.props.favoriteId} ayahId={this.props.ayahId} favorited={this.props.favorited} count={this.props.favoriteCount}/>        
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
      memoryCount={e.dataset.memoryCount}
      favoriteId={e.dataset.favoriteId}
      favorited={e.dataset.favorited === 'true'}
      favoriteCount={e.dataset.favoriteCount}
    />,  
  e);
});