import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'


class FavoriteButton extends React.Component {

    constructor(props) {
        super(props);

        let name = <i className="fa fa-star-o"> favorite</i>;

        if (props.favorited) {
            name = <i className="fa fa-star"> favorited</i>;
        }

        this.state = {
            buttonName: name,
            favorited: props.favorited,
            favoriteId: props.favoriteid,
        };

        this.onButtonChange = this.onButtonChange.bind(this);
    }

    render() {
        let buttonClasses = "button button-default button-small button-block";
        if (this.state.favorited) buttonClasses += " button-favorited";
        return (
            <a className={buttonClasses} onClick={this.onButtonChange}>
                {this.state.buttonName}
            </a>
        );
    }

    onButtonChange(e) {
        var that = this;
        this.state.favorited = !this.state.favorited;

        if (this.state.favorited) {
            $.ajax({
                type: 'POST',
                url: '/api/v1/ayahs/' + this.props.ayahid + '/favorites',
              })
              .done(function(data){
                that.state.favoriteId = data.id;
                that.state.buttonName = <i className="fa fa-star"> favorited</i>;
                that.setState(that.state);
              });
        } else {
            $.ajax({
                type: 'DELETE',
                url: '/api/v1/ayahs/' + this.props.ayahid + '/favorites/' + this.state.favoriteId,
            })
            .done(function(data){
                that.state.favoriteId = 0;
                that.state.buttonName = <i className="fa fa-star-o"> favorite</i>;
                that.setState(that.state);
            });
        }
    }
}

FavoriteButton.propTypes = {
    favorited: PropTypes.bool.isRequired,
};


let htmlCollection = document.getElementsByClassName('favorite');
let elements = Array.from(htmlCollection);

elements.forEach(function(e){
    ReactDOM.render(<FavoriteButton favoriteid={e.dataset.favoriteid} favorited={e.dataset.favorited === "true"} ayahid={e.dataset.ayahid}/>, e);
});