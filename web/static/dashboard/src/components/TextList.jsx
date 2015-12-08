import React, { Component, PropTypes } from 'react';
import { TransitionMotionMotion, spring } from 'react-motion';

export default class TextList extends Component {
  render() {
    const { texts } = this.props;

    return (
      <ul className="TextList">
        {texts.map((text, index) =>
          <div className="Text">
            <h4>{text.from}</h4>
            <p>{text.message}</p>
          </div>
        )}
      </ul>
    );
  }
}

TextList.propTypes = {
  texts: PropTypes.arrayOf(PropTypes.shape({
    from: PropTypes.string.isRequired,
    message: PropTypes.string.isRequired
  }).isRequired).isRequired
};
