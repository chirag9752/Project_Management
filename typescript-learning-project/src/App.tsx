import './App.css'
import MyButton from './components/Button'
import CounterProvider from './components/provider/Counter'

function App() {

  return (
    <div>
       {/* <MyButton text="Click Me" /> */}
       <CounterProvider>
         <MyButton onClick={() => alert('helllo bhai')} text="Click Me Again" />
       </CounterProvider>
    </div>
  )
}

export default App
