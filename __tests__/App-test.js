/**
 * @format
 */

import React from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  Linking,
  TouchableOpacity
} from 'react-native';
// import { expect } from 'chai';
import App from '../App';
import { shallow, mount } from 'enzyme';

// Note: test renderer must be required after react-native.
// import renderer from 'react-test-renderer';

let mockOpenURL = jest.fn();
jest.mock('react-native/Libraries/Linking/Linking', () => ({
  openURL: mockOpenURL,
}));

describe('<App />', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = shallow(<App />);
  })
  
  it('renders three <App /> components', () => {
    expect(wrapper.find(StatusBar).length).toEqual(1);
  });

  it('renders the inner Counter', () => {
    wrapper.instance.sampleFn = jest.fn();;
    // const spy = jest.spyOn(Linking, 'openURL'); 
    const spy = jest.spyOn(App, 'sampleFn')
    const link = wrapper.find("Text[testID='app-google-link']");
    expect(link.length).toEqual(1)
    link.props().onPress()
    expect(wrapper.sampleFn).toHaveBeenCalled();
  });


  // it('execure sampleFn', () => {
  //   const link1 = wrapper.find("TouchableOpacity[testID='app-sample-btn']");
  //   console.log(link1)
  //   expect(link1).to.have.lengthOf(1);
  //   link1.props().onPress()
  // });

  // it('allows us to set props', () => {
  //   const wrapper = mount(<App bar="baz" />);
  //   expect(wrapper.props().bar).to.equal('baz');
  //   wrapper.setProps({ bar: 'foo' });
  //   expect(wrapper.props().bar).to.equal('foo');
  // });
});