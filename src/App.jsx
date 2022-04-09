import { useState } from 'react'
import logo from './logo.svg'
import Install from './components/Install'
import Home from './components/Home'
import { ChakraProvider } from '@chakra-ui/react'
import theme from './config/config'


function App() {

  if (window.ethereum) {
    return 
    <> 
    <ChakraProvider resetCSS theme={theme}>
    <Home />
    </ChakraProvider>
    </>
   
  } else {
    return <Install />
  }
}

export default App
