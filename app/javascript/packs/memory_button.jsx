import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'


class MemoryButton extends React.Component {

    constructor(props) {
        super(props);

        let name = <i className="fa fa-heart-o"> memorize</i>;

        if (props.memorized) {
            name = <i className="fa fa-heart"> memorized</i> ;
        }

        this.state = {
            buttonName: name,
            memorized: props.memorized,
            memoryId: props.memoryid,
        };

        this.onButtonChange = this.onButtonChange.bind(this);
    }

    render() {
        let buttonClasses = "button button-default button-small button-block";
        if (this.state.memorized) buttonClasses += " button-memorized";
        return (
            <a className={buttonClasses} onClick={this.onButtonChange}>
                {this.state.buttonName}
            </a>
        );
    }

    onButtonChange(e) {
        var that = this;
        this.state.memorized = !this.state.memorized;

        if (this.state.memorized) {
            $.ajax({
                type: 'POST',
                url: '/api/v1/ayahs/' + this.props.ayahid + '/memories',
              })
              .done(function(data){
                that.state.memoryId = data.id;
                that.state.buttonName = <i className="fa fa-heart"> memorized</i>;
                that.setState(that.state);
              });
        } else {
            $.ajax({
                type: 'DELETE',
                url: '/api/v1/ayahs/' + this.props.ayahid + '/memories/' + this.state.memoryId,
            })
            .done(function(data){
                that.state.memoryId = 0;
                that.state.buttonName = <i className="fa fa-heart-o"> memorize</i>;
                that.setState(that.state);
            });
        }
    }
}

MemoryButton.propTypes = {
    memorized: PropTypes.bool.isRequired,
};


let htmlCollection = document.getElementsByClassName('memory');
let elements = Array.from(htmlCollection);

elements.forEach(function(e){
    ReactDOM.render(<MemoryButton memoryid={e.dataset.memoryid} memorized={e.dataset.memorized === "true"} ayahid={e.dataset.ayahid}/>, e);
});