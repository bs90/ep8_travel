"use client";

import { Provider } from "react-redux";
import { persistStore } from "redux-persist";
import { PersistGate } from "redux-persist/integration/react";

import { useStore } from "@/stores";
import Test from "@/components/test.component";

const Home = () => {
  const store = useStore();
  const persistor = persistStore(store);

  return (
    <Provider store={store}>
      <PersistGate persistor={persistor}>
        <div>
          <Test />
        </div>
      </PersistGate>
    </Provider>
  );
};

export default Home;
