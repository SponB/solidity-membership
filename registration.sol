pragma solidity ^0.4.18;

/*
 * Basic Registration System
 *
 * Author : Sebastien Mesili <sebastien@codeartist.co.kr>
 *
 * Purpose : 
 *  
 * This smart contract allows users to register with their 
 * ethereum addresses. 
 * Owner of the smart contract can add administrators.
 * Administrators can activate and deactivate users.
 * Users can register and unregister (but not activate and 
 * deactivate their own accounts)
 * 
 * License : 
 * Copyright 2018 Code Artist
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in the 
 * Software without restriction, including without limitation the rights to use, copy, 
 * modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
 * and to permit persons to whom the Software is furnished to do so, subject to the 
 * following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies 
 * or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
 * CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
 * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

contract Registration {

    mapping(address => uint) public active;
    mapping(address => uint) public register;
    mapping(address => uint) private admins;
    address private _owner;

    /* 
       Events    
    */
    
    event Registered(address indexed from);
    event Unregistered(address indexed from);
    event Activated(address indexed admin, address indexed user);
    event Deactivated(address indexed admin, address indexed user);


    /* 
       Modifiers    
    */

    modifier isOwner {
        require(msg.sender == _owner);
        _;
    }

    modifier isAdmin {
        require(admins[msg.sender] == 1);
        _;
    }

    modifier notRegistered {
        require(register[msg.sender] == 0);
        _;
    }
    
    modifier notActive{
        require(active[msg.sender] == 0);
        _;
    }

    modifier isRegistered {
        require(register[msg.sender] == 1);
        _;
    }
    
    modifier isActive{
        require(active[msg.sender] == 1);
        _;
    }


    /* 
       Public methods    
    */

    function Registration() public {
        _owner = msg.sender;
    }

    function () external payable {
        assert(false);
    }

    function addAdmin(address u) isOwner public {
        admins[u] = 1;
    }

    function removeAdmin(address u) isOwner public {
        admins[u] = 0;
    }

    function addMe() public notRegistered {
        register[msg.sender] = 1;
    }

    function removeMe() public isRegistered {
        active[msg.sender] = 0;
        register[msg.sender] = 0;
    }

    function activate(address u) isAdmin isRegistered notActive public {
        active[u] = 1;
    }

    function deactivate(address u) isAdmin isRegistered isActive public {
        active[u] = 0;
    }


}
