import { Body, Controller, Get, Post } from '@nestjs/common';
import { UserRepository } from './user.repository';
import { CreateUserDTO } from './dto/CreateUser.dto';

@Controller('/users')
export class UserController {
  constructor(private userRepository: UserRepository) {}

  @Post()
  async createUser(@Body() dataUser: CreateUserDTO) {
    this.userRepository.save(dataUser);
    return dataUser;
  }

  @Get()
  async listUsers() {
    return this.userRepository.getUsers();
  }
}
