import React from 'react'
import ReactDOM from 'react-dom'
import './index.css'
import App from './App'
import { ChakraProvider } from '@chakra-ui/react'
import theme from './config/config'
import { render } from "react-dom";
import { BrowserRouter, Routes , Route} from "react-router-dom";
import Header from './components/Header';


ReactDOM.render(
  <React.StrictMode>
    <ChakraProvider theme={theme}>
      <Header title='Escola'/>
    <BrowserRouter>
      <Routes > 
        <Route path='/' element={<App/>} />
      </Routes>
   </BrowserRouter>
    </ChakraProvider>
  </React.StrictMode>,
  document.getElementById('root')
)
