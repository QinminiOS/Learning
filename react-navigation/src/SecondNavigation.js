/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, {Component} from 'react';
import {
    View,
    Text,
    TouchableOpacity,
    StyleSheet,
} from 'react-native';
import {NavigationActions} from 'react-navigation';

export default class SecondNavigation extends Component {

    // 构造
      constructor(props) {
        super(props);

      }

    static navigationOptions = {
        title:'哈哈',
        gesturesEnabled:true
    };


    componentDidMount() {
        const setParamsAction = NavigationActions.setParams({
            params: { title: 'Hello' },
            key: 'Second',
        });
        this.props.navigation.dispatch(setParamsAction)
    }

    render() {
        return(
            <View style={styles.container}>
                <TouchableOpacity onPress={()=>{
                    this.props.navigation.navigate('Model',{'data':'haha'});
                }}>
                    <Text>下一个界面</Text>
                </TouchableOpacity>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex:1,
        justifyContent:'center',
        alignItems:'center',
        backgroundColor:'red'
    }
});