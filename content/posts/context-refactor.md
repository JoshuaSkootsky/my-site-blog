---
title: "Context Refactor"
date: 2021-02-01T18:38:30-05:00
draft: false
---

# Into to React Context

Intro to React Context, and how to do a quick refactor.

You might be designing an app from first principles, or being the lucky duck to architect something very neat and clean from scratch.

But, let's say you're doing something else - what if you're dealing with a pretty big project, and you realize suddenly that you want to share some state across the whole project?

You could use Redux and actions to do this.

In this case, with useState React Hooks, that will be enough. For the purposes of this post, assume that you're given some React state with the useState Hook, and your goal is to share that state to other components.

```react
  // src/root.js
  import React, { useState, createContext  } from 'react'; 

  export const modalContext = createContext();

  const AwesomeComponent = () => {

  const [isModalOpen, setModal] = useState(false)

  const ModalContextProvider = modalContext.Provider;

    return (
    <Router>
      <ModalContextProvider value={{isModalOpen, setModal}}>
          <Container>
             < AmazingoContent />
             <Footer setBestModal={setModal} />
          </Container>
      </ModalContextProvider>
    </Router>
    )

   }
```

Without changing anything about how the Footer component works, we've given access through Context to other components to access the value and set the state of whatever was defined with useState - in this case, the open/close value of a Modal component.

So, elsewhere, remember how the context was exported? As in:

```javascript
  // src/root.js

  export const modalContext = createContext();

```

So, that context can imported elsewhere, read, and even set.

```react
// somewhere in a deeply nested folder in /src

import React, useContext } from 'react';

import { modalContext } from '../../../../../root.js';

const NestedComponent = ({props}) => {
  const { isModalOpen, setModal } = useContext(modalContext)
  
  return (
    <div> onClick={setModal(!isModalOpen)}>
        <h1> Important Information </h1>
        <p> Click here to read some important information </p>
    </div>
    )
}

```

Now you've exported the state for that modal, along with the handler for its behavior, to a deeply nested component. Without prop drilling, you handed the handler down the tree of React components, without having to change anything else. All you had to do was define a context to make the values availible to any wrapped component that uses the useContext hook.

This also had great synergy with the existing use of the useState hook, making this an excellent and lightweight refactor to add more capabilities to your codebase.

Some of the syntax I used for useContext is just a preference I have at the time of writing this, I think I minimized the magic by making things maximally explicit and showing where the parts and pipes fit together for data flow.
