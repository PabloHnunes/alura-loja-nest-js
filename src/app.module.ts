import { Module } from '@nestjs/common';
import { UserModule } from './user/user.modulo';
import { ProductModule } from './product/product.modulo';

@Module({
  imports: [UserModule, ProductModule],
})
export class AppModule {}
