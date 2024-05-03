import { Table, Column, Model } from 'sequelize-typescript';

@Table
export class endereco extends Model {
  @Column({ primaryKey: true, autoIncrement: true })
  id_endereco: number;

  @Column
  cep: string;

  @Column
  rua: string;

  @Column
  cidade: string;

  @Column
  estado: string;

  @Column
  pais: string;

  @Column
  bairro: string;

  @Column
  numero: string;
}
