const authToken = (state = 'xxx', action) => {
  
  switch (action.type) {
    case 'SET_AUTH_TOKEN':
      console.log('SET_AUTH_TOKEN: ' + action.auth_token);	
      return action.auth_token;
    default:
      return state;
  }
}

export default authToken;