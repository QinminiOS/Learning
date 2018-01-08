/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
    Platform,
    StyleSheet,
    Text,
    View,
    Button,
    Alert,
    ListView,
} from 'react-native';

import {StackNavigator} from 'react-navigation';
import FirstNavigation from './src/FirstNavigation';
import SecondNavigation from './src/SecondNavigation';
import ModelNavigation from './src/ModelNavigation';
import CardStackStyleInterpolator from 'react-navigation/lib-rn/views/CardStack/CardStackStyleInterpolator'


const Nav = StackNavigator(
    {
        First:{
            screen:FirstNavigation,
            page:'home',
            title: "666"
        },
        Second:{
            screen:SecondNavigation,
            navigationOptions:({navigation}) => ({
                title: "sss"
            })
        },
        Model:{
            screen:ModelNavigation
        }
    },
    {
        initialRouteName:'First',
        initialRouteParams:{
            data:'haha'
        },
        navigationOptions:{
            headerTintColor:'red'
        },
        mode:'card',
        headerMode:'screen',
        cardStyle:({backgroundColor:'blue'}),
        onTransitionStart:((route)=>{
            console.log('开始动画');
        }),
        onTransitionEnd:((route)=>{
            console.log('结束动画');
        }),
    }
);

export default class App extends Component<{}> {
    constructor(props) {
      super(props);
      var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});

      var a = [];
      for (var i = 0; i < 100; i++) {
        a.push("row is " + i);
      }

      this.state = {
        dataSource: ds.cloneWithRows(a),
      };
    }

  render() {
    return (
        <Nav/>
    );
  }

  click() {
      // Alert.alert('Button has been pressed!')
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#ccff52',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
