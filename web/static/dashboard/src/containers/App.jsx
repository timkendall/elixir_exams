import React, { Component, PropTypes } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import * as TextActions from '../actions/texts'
import TextList from '../components/TextList.jsx';

class App extends React.Component {

  render() {
    const { texts, actions } = this.props;

    return (
      <div className="App">
        <h1>Incoming Texts</h1>
        <TextList texts={texts}></TextList>

        {this.props.children}
      </div>
    )
  }
}

App.propTypes = {
  texts: PropTypes.array.isRequired,
  actions: PropTypes.object.isRequired
}

function mapStateToProps(state) {
  return {
    texts: state.texts
  }
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(TextActions, dispatch)
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(App)
