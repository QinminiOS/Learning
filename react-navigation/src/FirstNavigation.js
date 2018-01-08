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

export default class FirstNavigation extends Component {

    static navigationOptions = {
        title:'6666',
        gesturesEnabled:true
    };

    componentDidMount() {
        const backAction = NavigationActions.back({
            key: 'Profile'
        });
        this.props.navigation.dispatch(backAction)
    }

    render() {
        return(
            <View style={styles.container}>
                <TouchableOpacity style={[styles.bg]} onPress={()=>{
                    this.props.navigation.navigate('Second',{'data':'haha'});
                }}>
                    <Text>跳转到第二个界面</Text>
                </TouchableOpacity>

            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex:1,
        justifyContent:'center',
        alignItems:'center'
    },
    bg: {
        height:40
    }
});