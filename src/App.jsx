import { useState } from 'react'
import logo from './logo.svg'
import Install from './components/Install'
import Home from './components/Home'


function App() {

  if (window.ethereum) {
    return (  
    <Home />
    )
  } else {
    return <Install />
  }
}

export default App
