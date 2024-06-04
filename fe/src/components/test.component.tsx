"use client";

import { useDispatch, useSelector } from "react-redux";

import { userSlice } from "@/stores/user";
import { RootState } from "@/stores";

const Test = () => {
  const dispatch = useDispatch();
  const { user } = useSelector((state: RootState) => state.user);
  const { updateUser } = userSlice.actions;

  const testReduxDispatch = () => {
    const testData = {
      name: "test data 123",
      age: 15,
    };
    dispatch(updateUser(testData));
  };

  return (
    <div>
      <p style={{color: "#000000"}}>{ user.name }</p>
      <button onClick={() => testReduxDispatch()}>Test Redux</button>
    </div>
  );

};

export default Test;
