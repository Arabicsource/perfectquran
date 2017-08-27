import React from 'react'
import ReactDOM from 'react-dom'

export default class FavoriteButton extends React.Component {

  state = {
    id: this.props.id,
    favorited: this.props.favorited,
    buttonClass: this.props.favorited ? "btn-ayah-action-favorited" : 'btn-ayah-action'
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
            favorited: false,
            buttonClass: 'btn-ayah-action'
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
          favorited: true,
          buttonClass: 'btn-ayah-action-favorited'
        })
      });
    }
  }

  render() {
    const { buttonClass } = this.state  

    return (
      <a className={buttonClass} onClick={() => this.toggleFavorite()}>
        <i className="fa fa-star"></i>
      </a>
    )
  }
}