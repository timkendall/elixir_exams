import * as types from '../constants/ActionTypes';

export function addText(text) {
  return { type: types.ADD_TEXT, text }
}
