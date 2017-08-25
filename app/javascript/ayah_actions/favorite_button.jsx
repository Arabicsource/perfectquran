import React from 'react'
import ReactDOM from 'react-dom'

export default class FavoriteButton extends React.Component {

  state = {
    id: this.props.id,
    buttonName: 'Favorite',
    favorited: this.props.favorited,
    buttonClass: this.props.favorited ? "ayah-action-button favorited" : 'ayah-action-button'
  }

  toggleFavorite() {
    const that = this
    const { id, favorited, buttonClass } = this.state
    
    if(favorited) {
      $.ajax({
        type: 'DELETE',
        url: '/api/v1/ayahs/' + this.props.ayahId + '/favorites/' + id,
      })
        .done(function(){
          that.setState({
            id: 0,
            buttonName: 'Favorite',
            favorited: false,
            buttonClass: 'ayah-action-button'
          })
        });
    } else {
      $.ajax({
        type: 'POST',
        url: '/api/v1/ayahs/' + this.props.ayahId + '/favorites',
      })
      .done(function(data){
        that.setState({
          id: data.id,
          buttonName: 'Favorited',
          favorited: true,
          buttonClass: buttonClass + ' favorited'
        })
      });
    }
  }

  render() {
    const { buttonName, buttonClass } = this.state  

    return (
      <a className={buttonClass} onClick={() => this.toggleFavorite()}>
        <i className="fa fa-star"></i> {buttonName}
      </a>
    )
  }
}