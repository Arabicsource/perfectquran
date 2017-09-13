import React from 'react'
import ReactDOM from 'react-dom'

export default class FavoriteButton extends React.Component {

  state = {
    id: this.props.id,
    favorited: this.props.favorited,
    buttonClass: this.props.favorited ? "favorited" : '',
    icon: this.props.favorited ? 'fa fa-star' : 'fa fa-star-o',
    count: this.props.count
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
            buttonClass: '',
            icon: 'fa fa-star-o',
            count: (Number.parseInt(that.state.count) - 1).toString()
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
          buttonClass: 'favorited',
          icon: 'fa fa-star',
          count: (Number.parseInt(that.state.count) + 1).toString()
        })
      });
    }
  }

  render() {
    const { buttonClass, icon, count } = this.state  

    return (
      <div>
        <a className={buttonClass} onClick={() => this.toggleFavorite()}>
          <i className={icon}></i>
        </a>
        <div>Favorites {count}</div>
      </div>
    )
  }
}