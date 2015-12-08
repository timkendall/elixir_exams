import { ADD_TEXT } from '../constants/ActionTypes';

const initialState = [
  { id: 0, from: 'Me', message: 'Test message' }
];

export default function texts(state = initialState, action) {
  switch (action.type) {
    case ADD_TEXT:
      return [
        {
          id: state.reduce((maxId, todo) => Math.max(todo.id, maxId), -1) + 1,
          from: action.text.from,
          message: action.text.message,
          isServiceReply: action.text.from === 'Elixir'
        },
        ...state
      ]
    default:
      return state
  }
}
