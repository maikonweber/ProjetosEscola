import { useState } from 'react'
import logo from './logo.svg'
import Install from './components/Install'
import Home from './components/Home'
import {
  BrowserRouter as Router,
  Route,
  Switch,
} from "react-router-dom";



function App() {

  if (window.ethereum) {
    return (
    <>  
    <Router >
      <Switch>
        <Route path='/'>
          <Home />
        </Route>
        </Switch>
     </Router >
    </>
    )
  } else {
    return <Install />
  }
}

export default App
