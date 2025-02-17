// import { useState } from "react";

// interface MyButtonProps {
//     text: string | number | boolean;
//     onClick ?: () => void;
//     something ?: boolean;
// }

// // type props = {text : string}


// interface Book {
//   name: string,
//   price: number
// }

// // React.FC what React.FC do here is " jo bhi ham isko type ya interface dete hai vo 
// // automatically props ke type me inject ho jaata hai see we give type string threw interface but it automatically give type to props "

// const MyButton: React.FC <MyButtonProps> = (props) => {
//     // const { text, onClick } = props;

//     const [value, setValue] = useState<string | undefined >();   // if we didn't give type explicitly i.e. useState<number>  then it automaticaly takes type as according to . when we give initial value

//     // const [values , setValues] = useState<Book>({
//     //   name: 'One',
//     //   price: 10
//     // })

//     const handleNameChange = (e: React.ChangeEvent<HTMLInputElement>) => {
//       setValue(e.target.value);
//     }

//     const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
//       e.preventDefault();
//       console.log(e);
//     }

//     return (

//         <div>
//         <h3>{value}</h3>
          
//           {/* new way just by destructuring  */}
//         {/* <button onClick={() => setValue(value + 1)}>{text}</button>

//         <h3>Name: {values.name} </h3>
//         <h3>RS: {values.price} </h3> */}

//         {/* <button onClick={() => setValues({ name : 'chirag',
//           price: 40
//          })} >click for change price and name</button> */}

//         <form onSubmit={handleSubmit}>
//          <input onChange={handleNameChange} type="text" placeholder="enter your name" />
//          <button type="submit">Submit</button>
//         </form>




//         {/* <button onClick={onClick}>{text}</button> */}
//         {/* <button onClick={props.onClick} >{props.text}</button> */}
//         </div>

       
//     )
// }

// export default MyButton;

import { useCounter } from "./provider/Counter";

interface MyButtonProps {
    text: string | number | boolean;
    onClick ?: () => void;
    something ?: boolean;
}

const MyButton: React.FC<MyButtonProps> = (props) => {

  const context = useCounter();

  return(
    <div>
        <h1 onClick={(e) => context?.setCount(context?.value + 1)} >
          {context?.value}
        </h1>
    </div>
  )
}