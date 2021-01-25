---
title: "React Hooks - Loading Data with useEffect and useState"
date: 2021-01-25T17:30:07-05:00
draft: false
---

# Using React Hooks for Fun and Profit


Let's say you realize that you want to get something from a database via the API. You know, like a useful website often does.

You want to display the results too, and you're using React on your front end.

First, get a useState hook running to have a place to store the results of your API call:

```javascript
import React, { useEffect, useState } from 'react';

const [content, setContent] = useState('');
```

Then get a useEffect hook running to load the data in asynchronously:


``` javascript
useEffect(() => {
    // useEffect can't be async
    // define an async function here and call it in useEffect
    const apiCall = async () => {
      const result = await getFromAPI();
      setContent(result); // set value of content hook you made earlier with useState
    }
    apiCall();
  }, []);
```

Note that the empty array as a second parameter, `[]`, means that this side effect only runs on page load. If you add other values into the dependency array, then useEffect will make the API call whenever those values change.

Now, you're using Redux, and you have an action that to make the API call depends on information in the Redux store. What to do?

Make an action in the form of a Redux asynchronous action creator, but don't dispatch anything to the Redux store. You're not using global application state to store the results of this API call, you just need it to 'live' locally in a useState hook.


So, with that in mind, define getFromAPI() something like this, along with your other actions that do dispatch things to your redux store:

``` javascript
  export const getFromAPI = () => async (dispatch, getState) => {
    // do not dispatch to store in redux state
    // but you can use getState if you need it
    const axiosConfig = {
      baseURL: process.env.YOUR_URL,
      headers: {
        'Content-Access-Key': getState().reduxStateCategory.contentAccessKey,
      },
      method: 'get',
      url: '/content',
    };
    const { data } = await axios(axiosConfig)
    return data;
  }
```

This then allows you elsewhere in the component with useEffect and useState to load 'content' (whatever it is), and it should take on the value of 'data' after axios requsts it on page load.



``` javascript
// display fetched content in JSX 
{ content }

```

The variable content, actually local state created with useState, will take on the value of the API call after it the API call completes.

This allows you to display content with local state, fetched remotely, without storing that value in your Redux store - which is much more lightweight, and appropriate if you don't need to share that data with other parts of your React site. 

In general I ask myself if something is global, application level state, or not. If not, I can keep it local and lightweight, which tends to be faster to write and has fewer moving parts to go wrong.


