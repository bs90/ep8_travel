import { PayloadAction, createSlice } from "@reduxjs/toolkit";

import { User } from "@/types/user";

type UserState = {
  user: User
}

const initialState: UserState = {
  user: {
    name: "test",
    age: 20
  }
};

export const userSlice = createSlice({
  name: "user",
  initialState,
  reducers: {
    updateUser(state, action: PayloadAction<User>) {
      state.user = action.payload;
    }
  }
});
