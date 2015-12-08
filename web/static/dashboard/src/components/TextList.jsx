import React, { Component, PropTypes } from 'react';
import { TransitionMotionMotion, spring } from 'react-motion';
import classNames from 'classnames';

export default class TextList extends Component {

  // Should be it's own `Text` component
  renderText(text) {
    const textClasses = classNames({
      Text: true,
      isServiceReply: text.isServiceReply
    });

    return (
      <div className={textClasses}>
        <h4>{text.from}</h4>
        <p>{text.message}</p>
      </div>
    )
  }

  render() {
    const { texts } = this.props;
    return (
      <ul className="TextList">
        {texts.map((text, index) =>
          this.renderText(text)
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
